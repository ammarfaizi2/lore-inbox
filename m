Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264164AbUEXNxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbUEXNxh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 09:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbUEXNxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 09:53:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30159 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264164AbUEXNxg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 09:53:36 -0400
Date: Mon, 24 May 2004 14:53:35 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Arjan van de Ven <arjanv@redhat.com>
Cc: hch@infradead.org, "Peter J. Braam" <braam@clusterfs.com>,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       "'Phil Schwan'" <phil@clusterfs.com>
Subject: Re: [PATCH/RFC] Lustre VFS patch
Message-ID: <20040524135334.GB17014@parcelfarce.linux.theplanet.co.uk>
References: <20040524114009.96CE13100E2@moraine.clusterfs.com> <20040524120858.GE26863@infradead.org> <1085406284.2780.13.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085406284.2780.13.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 03:44:44PM +0200, Arjan van de Ven wrote:
> > This is complete crap.  We don't want to methods for every namespace
> > operation.  
> 
> fun question: how does it deal with say a rename that would span mounts
> on the client but wouldn't on the server? :)

Should not be allowed.
