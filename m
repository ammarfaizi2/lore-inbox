Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269673AbUHZWQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269673AbUHZWQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269677AbUHZWPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:15:39 -0400
Received: from mail1.kontent.de ([81.88.34.36]:44444 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S269673AbUHZWCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:02:45 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
Subject: Re: PF_MEMALLOC in 2.6
Date: Fri, 27 Aug 2004 00:04:15 +0200
User-Agent: KMail/1.6.2
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Pete Zaitcev <zaitcev@redhat.com>, arjanv@redhat.com, alan@redhat.com,
       greg@kroah.com, linux-kernel@vger.kernel.org, riel@redhat.com,
       sct@redhat.com
References: <Pine.LNX.4.44.0408191320320.17508-100000@localhost.localdomain> <200408201052.51178.oliver@neukum.org> <20040826211642.GA30866@babylon.d2dc.net>
In-Reply-To: <20040826211642.GA30866@babylon.d2dc.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408270004.16534.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Storage cannot do concurrent IO.
> 
> I'm going to jump in here and ask a simple question, what is the
> blocking point that stops writes happening concurrent with reads?

The protocol on USB allows one command at a time only.

	Regards
		Oliver
