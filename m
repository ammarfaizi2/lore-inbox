Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264041AbRFWPTJ>; Sat, 23 Jun 2001 11:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264067AbRFWPTA>; Sat, 23 Jun 2001 11:19:00 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:31763 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264041AbRFWPSq>;
	Sat, 23 Jun 2001 11:18:46 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Der Herr Hofrat <der.herr@hofr.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: sizeof problem in kernel modules 
In-Reply-To: Your message of "Sat, 23 Jun 2001 16:54:20 +0200."
             <200106231454.f5NEsKu14812@kanga.hofr.at> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 24 Jun 2001 01:18:39 +1000
Message-ID: <16231.993309519@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2001 16:54:20 +0200 (CEST), 
Der Herr Hofrat <der.herr@hofr.at> wrote:
>struct { short x; long y; short z; }bad_struct;
>struct { long y; short x; short z; }good_struct;
>I would expect both structs to be 8byte in size , or atleast the same size !
>but good_struct turns out to be 8bytes and bad_struct 12 .

Read any C book about field alignment and padding in structures.
Nothing to do with the kernel or modules.

