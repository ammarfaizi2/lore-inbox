Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129589AbRBFTIy>; Tue, 6 Feb 2001 14:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129641AbRBFTIo>; Tue, 6 Feb 2001 14:08:44 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:47291 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129589AbRBFTIc>; Tue, 6 Feb 2001 14:08:32 -0500
From: Christoph Rohland <cr@sap.com>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: /dev/shm mount visible
In-Reply-To: <20010206160110.A4163@werewolf.able.es>
Organisation: SAP LinuxLab
Date: 06 Feb 2001 20:13:54 +0100
In-Reply-To: <20010206160110.A4163@werewolf.able.es>
Message-ID: <m3ofwfaakt.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2001, jamagallon@able.es wrote:
> Just a little question. In previous kernels and shm patches the
> /dev/shm filesytem was invisible under a 'mount' query (just managed
> like procfs or devpts). 

mount does always show all mounted fses. I asume you mean df.

> Now it appears listed under a mount command. Is it normal ?  Does
> mount show it coz it is no more 'special' or hidden in any way ?

Because shm fs now estimates the free space when not given any
limits. This is needed to use it as /tmp for some applications.

Greetings
		Christoph


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
