Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVDSTbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVDSTbX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 15:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVDSTbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 15:31:23 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:44499 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261638AbVDST3R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 15:29:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pDLgYVd6xvb8rsgnBmZSXpZTCbF2s1e1RJr8d452Co31iCLWILprAHdr/Xd02DaYZg+YFYVs0t9TeZsR3PWlbpWMjEECkuW61K5bKG4f8ZjlQUBvtQTPHKNZIrHHWft9ig7lE/C8+9EUUG0o1gOS24fMnDsxD984e/IcQDImVYw=
Message-ID: <a4e6962a05041912293ba87710@mail.gmail.com>
Date: Tue, 19 Apr 2005 14:29:14 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <Pine.LNX.4.58.0504191756200.3929@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3Ki1W-2pt-1@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it>
	 <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it>
	 <3UmnD-6Fy-7@gated-at.bofh.it>
	 <E1DNJZD-0006vK-11@be1.7eggert.dyndns.org>
	 <a4e6962a050419045752cc8be0@mail.gmail.com>
	 <Pine.LNX.4.58.0504191647320.3652@be1.lrz>
	 <a4e6962a05041908262df343f1@mail.gmail.com>
	 <Pine.LNX.4.58.0504191756200.3929@be1.lrz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somewhat related question for Viro/the group:

Why is CLONE_NEWNS considered a priveledged operation?  Would placing
limits on the number of private namespaces a user can own solve any
resource concerns or is there something more nefarious I'm missing?
