Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292560AbSBTWt4>; Wed, 20 Feb 2002 17:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292559AbSBTWto>; Wed, 20 Feb 2002 17:49:44 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:23024
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292553AbSBTWtd>; Wed, 20 Feb 2002 17:49:33 -0500
Date: Wed, 20 Feb 2002 14:49:52 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Allan Sandfeld <linux@sneulv.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Idiot-proof APIC?
Message-ID: <20020220224952.GB20060@matchmail.com>
Mail-Followup-To: Allan Sandfeld <linux@sneulv.dk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16dc5j-0000CB-00@Princess>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16dc5j-0000CB-00@Princess>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 08:07:47PM +0100, Allan Sandfeld wrote:
> Hi, I just want to share some of my stupidity and my experience with it with 
> you. 
> I recently had the misfortune to try to put two celerons on an SMP-board. The 
> bios correctly ignored the second cpu, but the linux-kernel(2.4.17). Would 
> boot almost normally then emit two APIC-errors to the console(error 2 and 
> 6?), and shortly after freeze completely. After one of the celerons was 
> removed linux was completely stable. Something inside makes me question 
> whether or not the APIC people have taken idiots into consideration. The 
> kernel should detect two cpu, detect they are not SMP and then operate using 
> just one. Not very importent, but correct behavior.
> Anyway for specs the board it was an Acorp 6A815EPD. Proberbly the one of the 
> only SMP i815 mortherboards in the world.
> 

Actually, with the correct adapters, celerons can be made SMP safe.

I would immagine that it is hard to detect if there is a adapter operating
correctly from the APIC code...

Mike
