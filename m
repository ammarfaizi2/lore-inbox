Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbTL0Ojh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 09:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264473AbTL0Ojh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 09:39:37 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:51466 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264471AbTL0Ojg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 09:39:36 -0500
Date: Sat, 27 Dec 2003 15:51:02 +0100
To: Bruce Ferrell <bferrell@baywinds.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: is it possible to have a kernel module with a BSD license?!
Message-ID: <20031227145102.GA14464@hh.idb.hist.no>
References: <3FE9ADEE.1080103@baywinds.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE9ADEE.1080103@baywinds.org>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 24, 2003 at 07:17:02AM -0800, Bruce Ferrell wrote:
> from the project announcement on freshmeat:
> 
> 
>  Dazuko 2.0.0-pre5 (Default)
>  by John Ogness - Tuesday, November 11th 2003 06:56 PST
> 
> About:
> This project provides a kernel module which provides 3rd-party 
> applications with an interface for file access control. It was 
> originally developed for on-access virus scanning. Other uses include a 

"On access" seems to be exactly the wrong moment for a virus check - 
that way you are getting the check delay at the worst moment, when
the user actually want to use the file.  

Consider doing virus checking on write only, viruses spread
only at that time.  

Virus checkers that run during idle time s also a good idea.

Helge Hafting
