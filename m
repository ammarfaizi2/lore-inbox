Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWCBLgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWCBLgA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 06:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWCBLgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 06:36:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23202 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751410AbWCBLgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 06:36:00 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060302084448.GA21902@infradead.org> 
References: <20060302084448.GA21902@infradead.org>  <440613FF.4040807@vilain.net> 
To: Christoph Hellwig <hch@infradead.org>
Cc: Sam Vilain <sam@vilain.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>
Subject: Re: [Fwd: [PATCH 3/5] NFS: Abstract out namespace initialisation [try #2]] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Thu, 02 Mar 2006 11:35:48 +0000
Message-ID: <3254.1141299348@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> > The attached patch abstracts out the namespace initialisation so that 
> > temporary namespaces can be set up elsewhere.
> 
> Definitily shouldb't be inline.  And until you have a second caller
> it's utterly pointless.  So NACK for now.

I presume from that you didn't notice that the second caller was in patch 5/5?

David
