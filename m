Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132612AbQKZTG4>; Sun, 26 Nov 2000 14:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132611AbQKZTGq>; Sun, 26 Nov 2000 14:06:46 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:2205 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S132240AbQKZTGe>;
        Sun, 26 Nov 2000 14:06:34 -0500
Date: Sun, 26 Nov 2000 13:36:28 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Elmer Joandi <elmer@ylenurme.ee>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <Pine.LNX.4.10.10011261942420.11180-100000@yle-server.ylenurme.sise>
Message-ID: <Pine.GSO.4.21.0011261321580.3258-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 Nov 2000, Elmer Joandi wrote:

> 
> Kernel has become so big that it really needs universal  debugging macros
> instead of comments. Comments are waste of brain&fingerpower, if the same
> can be explained by long variable names and debug macros.
> 
> static Subsystem_module_LocalVariableForThisPurpose;
> 
> int Subsytem_module_function_this_and_that(){
> 	DEBUG_ASSERT( Subsystem_module_LocalVariableForThisPurpose  == 0 );
> 	DEBUG_ASSERT(MOST_OF_TIME,FS_AREA,MYFS_MODULE, somethingaboutIndodes->node != NULL )
> }

I would suggest you to read through the following book and files:
	* Kernighan & Pike, "The Practice of Programming"
	* Documentation/CodingStyle
	* drivers/net/aironet4500_proc.c
and consider, erm, discrepancies. On the second thought, reading K&R
might also be useful. IOW, no offense, but your C is bad beyond belief.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
