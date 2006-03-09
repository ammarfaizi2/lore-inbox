Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWCITAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWCITAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 14:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWCITAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 14:00:17 -0500
Received: from test-iport-1.cisco.com ([171.71.176.117]:63817 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751337AbWCITAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 14:00:11 -0500
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, rolandd@cisco.com, gregkh@suse.de,
       akpm@osdl.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 18 of 20] ipath - kbuild infrastructure
X-Message-Flag: Warning: May contain useful information
References: <ac5354bb50d515de2a5c.1141922831@localhost.localdomain>
	<ada4q27ld33.fsf@cisco.com> <20060309185604.GA24004@mars.ravnborg.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 11:00:07 -0800
In-Reply-To: <20060309185604.GA24004@mars.ravnborg.org> (Sam Ravnborg's message of "Thu, 9 Mar 2006 19:56:04 +0100")
Message-ID: <adafylrigug.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 19:00:10.0847 (UTC) FILETIME=[B0A156F0:01C643AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Sam> Eventually - yes.  But not just now. Kbuild was introduced
    Sam> because it was needed in the top-level directory and it made
    Sam> good sense to do so.  But for now keeping Makefile is a good
    Sam> choice. This is anyway what people are used to.

OK, disregard my suggestion then.  Should we patch
Documentation/kbuild/makefiles.txt to correct the current
documentation, which says:

  The preferred name for the kbuild files is 'Kbuild' but 'Makefile'
  will continue to be supported. All new developmen is expected to use
  the Kbuild filename.

 - R.
