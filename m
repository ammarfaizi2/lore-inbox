Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130708AbRBTUTV>; Tue, 20 Feb 2001 15:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130735AbRBTUTL>; Tue, 20 Feb 2001 15:19:11 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:22389
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S130708AbRBTUTA>; Tue, 20 Feb 2001 15:19:00 -0500
Date: Tue, 20 Feb 2001 21:18:51 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: rsync on newer kernel does not quite work?
Message-ID: <20010220211851.B786@jaquet.dk>
In-Reply-To: <20010219230933.A823@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010219230933.A823@jaquet.dk>; from rasmus@jaquet.dk on Mon, Feb 19, 2001 at 11:09:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2001 at 11:09:33PM +0100, Rasmus Andersen wrote:
[...]

(I'll just continue talking to myself in the hope that somebody
will read this and be inspired.)

In order to clear things up I should clearly state that my rsync
problem manifests itself under local operation. Ie., 'rsync -arv
linux-242p4/ linux' will hang. No network is involved and the
problem does not manifest itself under 2.2.X kernels with the
exact same dataset.

Also, I have played around with strace and discovered that if I
make strace follow the children too the hang goes away. So
'strace rsync -arv linux-242p4/ linux' hangs (in wait4, btw)
while 'strace -f rsync -arv linux-242p4/ linux' does not.
I hope this will mean something to somebody. I can put up
strace output on the net if anybody profess any interest.

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"There are also enough rocks on Earth to kill the world's population several
times over."
	-- Lt. General Daniel Graham, DIA, explaining why it's necessary to
	   have more than enough nukes
