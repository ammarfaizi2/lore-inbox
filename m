Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266443AbTABTps>; Thu, 2 Jan 2003 14:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266453AbTABTps>; Thu, 2 Jan 2003 14:45:48 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:11203 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S266443AbTABTpr>; Thu, 2 Jan 2003 14:45:47 -0500
Date: Thu, 2 Jan 2003 20:54:09 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: sam@ravnborg.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Documentation/modules.txt
Message-ID: <20030102195409.GD17053@louise.pinerecords.com>
References: <20030102192751.GA18197@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030102192751.GA18197@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Anyway, your first step is to compile the kernel, as explained in the
>  file linux/README.  It generally goes like:
>  
> -	make config
> -	make dep
> +	make *config <= usually menuconfig or xconfig
>  	make clean
>  	make zImage or make zlilo

Won't 'dep' be necessary for modversions?

-- 
Tomas Szepe <szepe@pinerecords.com>
