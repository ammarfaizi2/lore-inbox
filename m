Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbSLMN3T>; Fri, 13 Dec 2002 08:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262913AbSLMN3T>; Fri, 13 Dec 2002 08:29:19 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:57033
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262877AbSLMN3T> convert rfc822-to-8bit; Fri, 13 Dec 2002 08:29:19 -0500
Subject: Re: Local APIC(?)+PIII mobile
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?Jo=E3o?= Seabra <seabra@aac.uc.pt>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200212131156.11262.seabra@aac.uc.pt>
References: <200212131156.11262.seabra@aac.uc.pt>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Dec 2002 14:15:05 +0000
Message-Id: <1039788905.25286.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-13 at 11:56, João Seabra wrote:
>  I have an Asus S8600. 
>  Mobile PIII 800Mhz + 192M RAM.
>  If i select "Local APIC support on uniprocessors" the kernel while booting 
> says there's no APIC present.Why?
>  I know the same problem with some other laptops.
>  Others detect it.

Because there isn't one present 8)

The APIC although on processor isnt present in all processors - at least
not all older ones. Its not a required CPU feature so not every
processor vendor includes it on all their processors.

Alan


