Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288597AbSA3F5j>; Wed, 30 Jan 2002 00:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288668AbSA3F5a>; Wed, 30 Jan 2002 00:57:30 -0500
Received: from zero.tech9.net ([209.61.188.187]:42251 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288597AbSA3F50>;
	Wed, 30 Jan 2002 00:57:26 -0500
Subject: Re: Configure.help in 2.5.3-pre6
From: Robert Love <rml@tech9.net>
To: Ben Clifford <benc@hawaga.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201292147530.22800-100000@barbarella.hawaga.org.uk>
In-Reply-To: <Pine.LNX.4.33.0201292147530.22800-100000@barbarella.hawaga.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 30 Jan 2002 01:03:13 -0500
Message-Id: <1012370595.3392.21.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-30 at 00:51, Ben Clifford wrote:
> 
> 2.5.3-pre6 gets rid of Documentation/Configure.help and replaces it by
> smaller files nearer their use. This seems to have broken the help
> facility in menuconfig (and possibly the other configs)
> 
> I've generated one at config time using a makefile target like this:
> 
> Documentation/Configure.help:
>         cat `find -name Config.help` > Documentation/Configure.help
> 
> Is this the way that it is intended to work, or should I be making extra
> effort to not include the .help for the wrong architecture?

The intention is to fix [menu|x]config.  I believe plain 'ol `make
config' works.  The new per-config.in config.help is here to stay.

	Robert Love

