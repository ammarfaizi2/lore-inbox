Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVIFEHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVIFEHe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 00:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbVIFEHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 00:07:34 -0400
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:37744 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932198AbVIFEHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 00:07:34 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Daniel Phillips <phillips@istop.com>
Subject: Re: GFS, what's remainingh
Date: Mon, 5 Sep 2005 23:07:26 -0500
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>,
       Andi Kleen <ak@suse.de>, linux clustering <linux-cluster@redhat.com>,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <200509052103.20519.dtor_core@ameritech.net> <200509060002.40823.phillips@istop.com>
In-Reply-To: <200509060002.40823.phillips@istop.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509052307.27417.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 September 2005 23:02, Daniel Phillips wrote:
> 
> By the way, you said "alpha server" not "alpha servers", was that just a slip?  
> Because if you don't have a cluster then why are you using a dlm?
>

No, it is not a slip. The application is running on just one node, so we
do not really use "distributed" part. However we make heavy use of the
rest of lock manager features, especially lock value blocks.

-- 
Dmitry
