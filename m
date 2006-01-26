Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWAZQGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWAZQGb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 11:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWAZQGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 11:06:31 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:50310 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932353AbWAZQGa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 11:06:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AdB+KVRJltf8B7b4GKPmmielLkJ9VDTsEq65iNRUFghOM5e4eoXdyX8wbBW7QyrfjY5ghgQGMXa6roKFnMN2f5WpU4HLo3Wc35EwJLbjkT3m4O+bCxVAjV9/E0vr23e0vJsFJoW3+Q5J2zj0NmvJ3BnrLoGqnIoveH/z+xx4Qr0=
Message-ID: <cfb54190601260806h7199d7aej79139140d145d592@mail.gmail.com>
Date: Thu, 26 Jan 2006 18:06:29 +0200
From: Hai Zaar <haizaar@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: vesa fb is slow on 2.6.15.1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43D8E1EE.3040302@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cfb54190601260620l5848ba3ai9d7e06c41d98c362@mail.gmail.com>
	 <43D8E1EE.3040302@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>
> mtrr now defaults to off in vesafb because of conflicts with xorg/
> xfree86.  You have to explicitly enable it with a boot option.  Try
> this:
>
> video=vesafb:mtrr:3,ypan
>
> Tony
>
I've replaced 'vga=795' with 'video=vesafb:mtrr:3,ypan' and rebooted.
Now framebuffer is not activated at all - I get plain old 80x25
console. Are you sure that old vesafb (not vesafb-tng) driver
understands 'video=...' parameters style?

--
Zaar
