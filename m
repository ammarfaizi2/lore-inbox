Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWEAVTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWEAVTo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWEAVTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:19:44 -0400
Received: from uproxy.gmail.com ([66.249.92.171]:11940 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751260AbWEAVTo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:19:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=pYbQ6G8p6UmFx97hZbmGzivz5zvjB0CFhBp+FJDyV2Ln1dsRLurYD39l8/IARVMqK/fhQhYN81DDKDop0nd2j17DEuUgIZnotzjNw7/SgfBxX4OP9Mp09Tc39cnqB/HUajc+oNi92NB7wQ7wYXRGhea18oUF4ZvTrLFldSiGBHY=
Message-ID: <b6c5339f0605011419w7770a634t60bce8ce693a3749@mail.gmail.com>
Date: Mon, 1 May 2006 17:19:42 -0400
From: "Bob Copeland" <me@bobcopeland.com>
To: "Alexey Dobriyan" <adobriyan@gmail.com>
Subject: Re: [PATCH] fs/bio.c: initialize variable, remove warning
Cc: "Petri T. Koistinen" <petri.koistinen@iki.fi>,
       "Andrew Morton" <akpm@osdl.org>, trivial@kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060501210546.GB7170@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0605012353100.5245@joo>
	 <20060501210546.GB7170@mipter.zuzino.mipt.ru>
X-Google-Sender-Auth: 9790520591ff14f7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/06, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Mon, May 01, 2006 at 11:55:27PM +0300, Petri T. Koistinen wrote:
> > Remove compiler warning by initializing uninitialized variable.
>
> oh no not again!

What about:

> > -                     unsigned long idx;
+                     unsigned long idx;   /* please don't patch bogus
warning */

:)
-Bob
