Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261669AbSKCHeF>; Sun, 3 Nov 2002 02:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261677AbSKCHeF>; Sun, 3 Nov 2002 02:34:05 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:25362 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261669AbSKCHeE>;
	Sun, 3 Nov 2002 02:34:04 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: invalid character 45 in exportstr for include-config 
In-reply-to: Your message of "02 Nov 2002 22:20:11 -0800."
             <1036304411.17126.1.camel@rth.ninka.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 03 Nov 2002 18:40:20 +1100
Message-ID: <21441.1036309220@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 Nov 2002 22:20:11 -0800, 
"David S. Miller" <davem@redhat.com> wrote:
>Kai, this fixes the problem I reported to you on sparc64 with
>make-3.79   What version of make do you have which accepted this
>variable name with a dash in it?

The message is not coming from make, make accepts almost any variable
name in export.  The message comes from bash, which restricts the
format of exported names.

