Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312600AbSDPTIj>; Tue, 16 Apr 2002 15:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312855AbSDPTIi>; Tue, 16 Apr 2002 15:08:38 -0400
Received: from [194.46.8.33] ([194.46.8.33]:37384 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S312600AbSDPTIi>;
	Tue, 16 Apr 2002 15:08:38 -0400
Date: Tue, 16 Apr 2002 19:05:06 +0100
From: Dale Amon <amon@vnl.com>
To: linux-kernel@vger.kernel.org
Subject: ETA on Buslogic driver fixes for 2.5?
Message-ID: <20020416180506.GA15960@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.8 still won't compile for me since my test machine (for that
matter quite a few of my machines) has a Buslogic SCSI:

init/main.c: In function `start_kernel':
init/main.c:347: warning: implicit declaration of function `setup_per_cpu_areas'
ide-proc.c: In function `create_proc_ide_drives':
ide-proc.c:425: warning: unused variable `ent'
BusLogic.c:32: #error Please convert me to Documentation/DMA-mapping.txt
BusLogic.c: In function `BusLogic_QueueCommand':
BusLogic.c:3406: structure has no member named `address'
BusLogic.c: In function `BusLogic_BIOSDiskParameters':
BusLogic.c:4132: warning: implicit declaration of function `scsi_bios_ptable'
BusLogic.c:4132: warning: assignment makes pointer from integer without a cast
make[3]: *** [BusLogic.o] Error 1
make[2]: *** [first_rule] Error 2
make[1]: *** [_subdir_scsi] Error 2
make: *** [_dir_drivers] Error 2

I spoke with Andy about a month ago, but his email address has 
since gone bad. Is anyone working on the Buslogic and is
there any time frame on when 2.5 might support it? I'm in
no rush, I'd just like to play.
