Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293106AbSB1T3c>; Thu, 28 Feb 2002 14:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293684AbSB1T0Y>; Thu, 28 Feb 2002 14:26:24 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:22033 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S293697AbSB1TYr>; Thu, 28 Feb 2002 14:24:47 -0500
Date: Thu, 28 Feb 2002 15:15:59 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Tigran Aivazian <tigran@veritas.com>
Cc: asit.k.mallick@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.18] serialize microcode updates
In-Reply-To: <Pine.LNX.4.33.0202281653410.1220-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.21.0202281513160.2182-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Feb 2002, Tigran Aivazian wrote:

> Greetings Marcelo,
> 
> The attached patch is against 2.4.18 and serializes the microcode update
> because it has to be done like that in certain cases and it does no harm
> to do it in all cases.
> 
> Also, it avoids the silly message "upgrading from N to M" where M==N,
> which was confusing enough to generate lots of email in my inbox :)
> Because now only one update can happen at a time the above workaround is
> no longer needed so it was removed.

Tigran, 

Your patch does not apply cleanly to my tree...


