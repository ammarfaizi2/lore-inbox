Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRALNNd>; Fri, 12 Jan 2001 08:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131153AbRALNNX>; Fri, 12 Jan 2001 08:13:23 -0500
Received: from gate.in-addr.de ([212.8.193.158]:55818 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S129183AbRALNNE>;
	Fri, 12 Jan 2001 08:13:04 -0500
Date: Fri, 12 Jan 2001 14:13:02 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: shmfs behaviour
Message-ID: <20010112141302.M441@marowsky-bree.de>
In-Reply-To: <20010112111039.A2160@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.3i
In-Reply-To: <20010112111039.A2160@werewolf.able.es>; from "J . A . Magallon" on 2001-01-12T11:10:39
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-01-12T11:10:39,
   "J . A . Magallon" <jamagallon@able.es> said:

> A couple of questions about shm filesystem:
> - Time ago I remember you could see some dot files inside the /dev/shm
>   filesystem (then, even it was mounted in /var/shm...). No it shows nothing.
>   Is it the supposed behaviour ?

AFAIK yes.

> - By accident (switching between 2.2 and 2.4), i left the shm fs 'commented'
>   (with a fs type of 'ignore'). Kernel 2.4 looked working good. What is
>   /dev/shm for exactly ? Because it looks like I can live without it...

No. You will need it for POSIX shared memory.

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
