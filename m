Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262234AbSJATL3>; Tue, 1 Oct 2002 15:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbSJATL3>; Tue, 1 Oct 2002 15:11:29 -0400
Received: from tbaytel3.tbaytel.net ([206.47.150.179]:9431 "EHLO tbaytel.net")
	by vger.kernel.org with ESMTP id <S262240AbSJATL2> convert rfc822-to-8bit;
	Tue, 1 Oct 2002 15:11:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Garrett Kajmowicz <gkajmowi@tbaytel.net>
Reply-To: gkajmowi@tbaytel.net
Organization: Garrett Kajmowicz
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH, TRIVIAL] 2.4.20-pre8 BeFS Config.in modification
Date: Tue, 1 Oct 2002 15:12:08 -0400
User-Agent: KMail/1.4.1
References: <200210011448.06125.gkajmowi@tbaytel.net> <20021001190648.GA24193@suse.de>
In-Reply-To: <20021001190648.GA24193@suse.de>
Cc: davej@codemonkey.org.uk
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210011512.08679.gkajmowi@tbaytel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If those filesystems had a dozen options each, it'd be worthwhile
> perhaps. Saving 1-2 lines per-fs for the whole fs/Config.in
> makes this seem not-so-worthwhile imo, but others may think otherwise..
>
> 		Dave

I am not doing this to reduce the size of the Config.in files.  I am doing it 
because my main project (writing a script to provide stripped-down versions 
of the Linux kernel source code for people over slower connections) all but 
requires everything neat and in it's own directory for optimal performance.  
I could use a lot of grep/gawk but that would cause more problems for people 
who wanted to download the stripped source code.

Besides, it's The Right Thing To Do {tm}

Please Cc any comments to:

Garrett Kajmowicz
gkajmowi@tbaytel.net
