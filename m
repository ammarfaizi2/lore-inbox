Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVCRPk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVCRPk5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 10:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVCRPjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 10:39:02 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:17612 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261636AbVCRPgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 10:36:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Uzl8xQJlfnnGO9iCKdRBH9RXtFYkWJcXCtyKvudVhqDEM+bzjHd9khQH5Ig9xhGWj3f7qfpgDdH8SSZMP4TtK4y19VGPajxiBEbIx4qM3hV8MIoxc44zw/A53Q05QEh4G8Ok/jJfeKR/Br24U+GvYKfZ34QBceHdASXW3CatfWQ=
Message-ID: <d120d500050318073671f15ad6@mail.gmail.com>
Date: Fri, 18 Mar 2005 10:36:14 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: dave <dave.m@email.it>
Subject: Re: PROBLEM: 2.6.11.4 vaio z1xmp mouse click
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200503141916.30252.dave.m@email.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <200503141916.30252.dave.m@email.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005 19:16:29 +0100, dave <dave.m@email.it> wrote:
> 
> hy,
> 
> Upgrading kernel from Linux 2.6.10 (full) to 2.6.11.4(full) the left mouse
> click get losed (I can not clik).

Is your touchpad being detected as an ALPS touchpad? There are some
issues with tapping that should be fixed in 2.6.12. In the meantime
you could try 2.6.11-mm or force PS/2 compatinbility mode by bootintg
with psmouse.proto=exps on kernel command line.
-- 
Dmitry
