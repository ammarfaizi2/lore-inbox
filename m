Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWDKOtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWDKOtH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 10:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWDKOtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 10:49:07 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:32389 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751172AbWDKOtG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 10:49:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D81DPgRj8kch01lzh7WIVywUHOyl3/m4/VqGdI0FzyXute4LL4i8Xioxxu7D6aHKJxfN9PnQg71FQHJMLBiPJHVzYQgM2vc4rrZIXiCrJQ2U2qtb9ydPfAO0SI43ONi1x13pNVN3ppUIA3KErmNKknwttxR5bhhTK6r2MawyhP4=
Message-ID: <c70ff3ad0604110749s26e92345s60729434162c7212@mail.gmail.com>
Date: Tue, 11 Apr 2006 17:49:05 +0300
From: "saeed bishara" <saeed.bishara@gmail.com>
To: "Dimitry Andric" <dimitry@andric.com>
Subject: Re: add new code section for kernel code
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Paolo Ornati" <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-arm-toolchain@lists.arm.linux.org.uk
In-Reply-To: <443A2196.5090306@andric.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c70ff3ad0604060545o2e2dc8fcg2948ca53b3b3c8b0@mail.gmail.com>
	 <20060406151003.0ef4e637@localhost>
	 <c70ff3ad0604060947t728fbad9g2e3b35198f9b0f66@mail.gmail.com>
	 <c70ff3ad0604070402p355a5695y28b5806cbf7bed0a@mail.gmail.com>
	 <1144422864.3117.0.camel@laptopd505.fenrus.org>
	 <20060407154349.GB31458@flint.arm.linux.org.uk>
	 <c70ff3ad0604090253n7fe4de4che67f18380ffa2efd@mail.gmail.com>
	 <20060409203046.GA24461@flint.arm.linux.org.uk>
	 <443A2196.5090306@andric.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inorder to reduce image size of the kenrel I added the --gc-secions
 flag to the LDFALGS_vmlinux, the image size reduced by 120KB (out of
1.8M), but the kernel failed to boot ( after the uncompression stage).
any idea?
I see that the fvr arch aleady using those flags.
