Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129175AbRA2UgQ>; Mon, 29 Jan 2001 15:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129184AbRA2UgG>; Mon, 29 Jan 2001 15:36:06 -0500
Received: from [213.95.15.193] ([213.95.15.193]:13318 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129175AbRA2Uf6>;
	Mon, 29 Jan 2001 15:35:58 -0500
Date: Mon, 29 Jan 2001 21:35:53 +0100
From: Andi Kleen <ak@suse.de>
To: Roman Zippel <zippel@fh-brandenburg.de>
Cc: Andi Kleen <ak@suse.de>, Timur Tabi <ttabi@interactivesi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
Message-ID: <20010129213553.A6552@gruyere.muc.suse.de>
In-Reply-To: <20010129182633.A2522@gruyere.muc.suse.de> <Pine.GSO.4.10.10101292036070.17869-100000@zeus.fh-brandenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.10.10101292036070.17869-100000@zeus.fh-brandenburg.de>; from zippel@fh-brandenburg.de on Mon, Jan 29, 2001 at 08:47:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2001 at 08:47:50PM +0100, Roman Zippel wrote:
> You still miss wakeups. :)

And there was another race in it, I know.  The first __set_task_state
has to be set_task_state to get the right memory write order on SMP. 




-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
