Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131440AbRCKO5F>; Sun, 11 Mar 2001 09:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131441AbRCKO44>; Sun, 11 Mar 2001 09:56:56 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:37126 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131440AbRCKO4t>;
	Sun, 11 Mar 2001 09:56:49 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: elenstev@mesatop.com
cc: linux-kernel@vger.kernel.org
Subject: Re: List of recent (2.4.0 to 2.4.2-ac18) CONFIG options needing Configure.help text. 
In-Reply-To: Your message of "Sun, 11 Mar 2001 06:37:10 PDT."
             <01031106371001.29664@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Mar 2001 01:56:03 +1100
Message-ID: <17646.984322563@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Mar 2001 06:37:10 -0700, 
Steven Cole <elenstev@mesatop.com> wrote:
>On Sunday 11 March 2001 00:08, Jeff Garzik wrote:
>> Keith Owens wrote:
>> > If any of these CONFIG_ options are always derived (i.e. the user never
>> > sees them on a config menu) then please add the suffix _DERIVED to such
>> > options.
>
>BTW, the script I used (originally written by Paul Gortmaker), does pass the
>lines in [C,c]onfig.in through grep -v define_ to catch items which are defined
>with define_bool or define_int.

Several options are define_bool in one config.in but are options in
another.  I am working on a global patch to rename all derived options.
It will be big.

