Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbQLTVoh>; Wed, 20 Dec 2000 16:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130524AbQLTVo0>; Wed, 20 Dec 2000 16:44:26 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:772 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130507AbQLTVoJ>;
	Wed, 20 Dec 2000 16:44:09 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Announce: modutils 2.3.23 is available 
In-Reply-To: Your message of "Wed, 20 Dec 2000 10:31:12 BST."
             <3A407C5F.C8BC2802@vz.cit.alcatel.fr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Dec 2000 08:13:36 +1100
Message-ID: <2901.977346816@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2000 10:31:12 +0100, 
Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr> wrote:
>About Standard aliases:
>> modprobe -c
>...
>alias ppp-compress-21 bsd_comp
>...
>
>Why bsd_comp is the standard alias?

You should also have
alias ppp-compress-24 ppp_deflate
alias ppp-compress-26 ppp_deflate

The number is the CPP option that was requested by pppd, which
compression option is used is controlled by userspaqce, not the kernel.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
