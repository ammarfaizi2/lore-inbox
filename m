Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265333AbTA1NGk>; Tue, 28 Jan 2003 08:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbTA1NGk>; Tue, 28 Jan 2003 08:06:40 -0500
Received: from uni00du.unity.ncsu.edu ([152.1.13.100]:32128 "EHLO
	uni00du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id <S265333AbTA1NGj>; Tue, 28 Jan 2003 08:06:39 -0500
From: jlnance@unity.ncsu.edu
Date: Tue, 28 Jan 2003 08:16:00 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: sendfile support in linux
Message-ID: <20030128131600.GA2946@ncsu.edu>
References: <057889C7F1E5D61193620002A537E8690B4387@NCBDC>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <057889C7F1E5D61193620002A537E8690B4387@NCBDC>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 05:45:20PM -0800, Stanley Yee wrote:
> I'm trying to find out more about sendfile(2).  So far, from what I've
> gathered, it sounds like the requirements for it are (please correct me if
> I'm wrong):
> 
> 1.  A kernel with sendfile support (i.e. 2.4.X)
> 2.  A network card capable of doing the TCP checksum in the hardware
> 3.  The application must support sendfile 

I believe that 2 is only necessary for zero-copy sendfile.  The system
call will work regardless of whether the network card does the TCP
checksum or not.

Thanks,

Jim
