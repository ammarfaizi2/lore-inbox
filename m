Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270206AbTHOQ5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267471AbTHOQzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:55:17 -0400
Received: from AMarseille-201-1-4-67.w217-128.abo.wanadoo.fr ([217.128.74.67]:46889
	"EHLO gaston") by vger.kernel.org with ESMTP id S270013AbTHOQzG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:55:06 -0400
Subject: Re: [BUG] slab debug vs. L1 alignement
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3F3D2B96.6060903@wanadoo.fr>
References: <1060956004.581.13.camel@gaston>  <3F3D2B96.6060903@wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060966471.643.57.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Aug 2003 18:54:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Attached untested patch should fix it (vs 2.6.0-test1), I've no
> idea if it's acceptable.

That will just disable redzoning, which isn't what I want...


