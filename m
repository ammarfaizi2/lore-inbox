Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265689AbSKTEIV>; Tue, 19 Nov 2002 23:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265732AbSKTEIV>; Tue, 19 Nov 2002 23:08:21 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:24036 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S265689AbSKTEIU>; Tue, 19 Nov 2002 23:08:20 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Peter Chubb <peter@chubb.wattle.id.au>
Date: Wed, 20 Nov 2002 15:15:14 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15835.3154.178557.663327@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rpc.mountd problem in 2.5.48
In-Reply-To: message from Peter Chubb on Wednesday November 20
References: <15834.1952.674371.221691@wombat.chubb.wattle.id.au>
	<15834.49275.238123.495190@notabene.cse.unsw.edu.au>
	<15834.51557.836769.918443@wombat.chubb.wattle.id.au>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 20, peter@chubb.wattle.id.au wrote:
> 
> Neil> I suspec that adding 'insecure' did not fix the problem, but
> Neil> rather it was trying again that fixed the problem.
> 
> Removing `insecure' and doing exportfs -r -a  brings the problem back
> again.

Extremely odd as the presence or absense of 'insecure' cannot (as far
as I can see) affect any of the messages that you are seeing.

Could you please:
  take a copy of /proc/fs/nfs/exports
  run strace on mountd
  try to boot the xterminal and have it fail
and show me the results?

Thanks
NeilBrown
