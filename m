Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270766AbUJUP05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270766AbUJUP05 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270770AbUJUP0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:26:18 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:64458 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S270764AbUJUPZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:25:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=t1efI95fLke4pqHrIbEb4HQMK0d6UtwGnFFZ5qR5THYdoCQOzlUYKLSjRHFFUo/+aIvzYqkgf8ezy2lsj+AzuGCrac+iPCPiuNhZ+m/vwAn3d7tUuugwUX5vjqroZx/kiYt2SKoXeC3IGyFHx7105hF5o7P256/j3gLx4TD6w0o=
Message-ID: <9e473391041021082571fa9440@mail.gmail.com>
Date: Thu, 21 Oct 2004 11:25:19 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Timothy Miller <miller@techsource.com>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4177D163.2000503@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4176E08B.2050706@techsource.com>
	 <1098313825.12374.74.camel@localhost.localdomain>
	 <4177D163.2000503@techsource.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An experimental feature I've heard being proposed is to generate font
bitmaps dynamically on the card. The idea is to load the TrueType
glyphs onto the card and then generate a temp bitmap when you know
exactly the size/subpixel alignment that you need. Implementing this
probably means you need 3D FP transform units. This is just an
experiment proposal, no one has built it yet so no one knows if it is
going to work very well. It might be an opportunity to try for some
patents.

-- 
Jon Smirl
jonsmirl@gmail.com
