Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbTDHMik (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 08:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbTDHMij (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 08:38:39 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60568
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261338AbTDHMih (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 08:38:37 -0400
Subject: Re: SET_MODULE_OWNER?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, zwane@linuxpower.ca,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hch@infradead.org
In-Reply-To: <20030408035210.02D142C06E@lists.samba.org>
References: <20030408035210.02D142C06E@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049802672.8120.14.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Apr 2003 12:51:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-08 at 04:46, Rusty Russell wrote:
> Unlike that, substituting dev->owner = THIS_MODULE; has no backwards
> compatibility loss, and it removes a confusing and pointless macro
> which *never* had a point.

Its an abstraction macro.

> Unless you can come up with a real *reason*, I'll move it back under
> "deprecated" and start substituting.

Thats fun, and the rest of us can play submit patches to substitute it
back. 

This is not how to work with people


