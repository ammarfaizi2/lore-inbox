Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751956AbWCBIou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbWCBIou (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 03:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbWCBIou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 03:44:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61062 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751956AbWCBIou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 03:44:50 -0500
Date: Thu, 2 Mar 2006 08:44:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Sam Vilain <sam@vilain.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>
Subject: Re: [Fwd: [PATCH 3/5] NFS: Abstract out namespace initialisation [try #2]]
Message-ID: <20060302084448.GA21902@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Sam Vilain <sam@vilain.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>
References: <440613FF.4040807@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440613FF.4040807@vilain.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 10:37:03AM +1300, Sam Vilain wrote:
> The attached patch abstracts out the namespace initialisation so that 
> temporary namespaces can be set up elsewhere.

Definitily shouldb't be inline.  And until you have a second caller
it's utterly pointless.  So NACK for now.

