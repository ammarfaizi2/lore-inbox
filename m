Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285060AbSBRTm3>; Mon, 18 Feb 2002 14:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284180AbSBRTkq>; Mon, 18 Feb 2002 14:40:46 -0500
Received: from clavin.cs.tamu.edu ([128.194.130.106]:64644 "EHLO cs.tamu.edu")
	by vger.kernel.org with ESMTP id <S285273AbSBRTkC>;
	Mon, 18 Feb 2002 14:40:02 -0500
Date: Mon, 18 Feb 2002 13:39:59 -0600 (CST)
From: Xinwen - Fu <xinwenfu@cs.tamu.edu>
To: linux-kernel@vger.kernel.org
Subject: want ip identification enabled
In-Reply-To: <Pine.SOL.4.10.10202180439080.14846-100000@dogbert>
Message-ID: <Pine.SOL.4.10.10202181335470.8734-100000@dogbert>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Now I get that on some OS, for UDP and ICMP packets, the ip
identification fields are not set. 

	But I want that every packet has an id. Is there any emthod to get
the current system glocal variable "ip_id" and change it or 
enable UDP and ICMP ip identification number somewhere?

	Thanks!

Xinwen Fu


On Mon, 18 Feb 2002, Xinwen - Fu wrote:

> Hi,
> 	Really weird!
> 
> 	I have two linux machines with kernel 2.4.17. When I ping one
> machine from the other machine, all the ping request ip packets have the
> same sequnce number 0. The ping reply packets have different ip
> sequence numbers. Moreover, when I send udp packets using general
> socket programming, all the udp packets have the same sequence number 0.
> 
> 	I use ethereal to check the packets.
> 
> 	What's the problem?
> 
> 	Thanks!
> 
> 
> 
> Xinwen Fu
> 
> 
> 

