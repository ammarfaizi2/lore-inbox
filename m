Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310614AbSCMOdy>; Wed, 13 Mar 2002 09:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310615AbSCMOdo>; Wed, 13 Mar 2002 09:33:44 -0500
Received: from ns.suse.de ([213.95.15.193]:56074 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310614AbSCMOd2>;
	Wed, 13 Mar 2002 09:33:28 -0500
Date: Wed, 13 Mar 2002 15:33:27 +0100
From: Dave Jones <davej@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.6 scsi DMA mapping and compilation fixes (not yet working)
Message-ID: <20020313153327.I7658@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Adam J. Richter" <adam@yggdrasil.com>, rmk@arm.linux.org.uk,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203130023.QAA08389@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200203130023.QAA08389@adam.yggdrasil.com>; from adam@yggdrasil.com on Tue, Mar 12, 2002 at 04:23:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 04:23:24PM -0800, Adam J. Richter wrote:

 > 	Maybe you are thinking of the patches that I posted a
 > while ago that included an update to some locking changes for
 > a bunch of the scsi drivers.  Alan spoke up and said that
 > I should not apply the NCR53C80 part of those patches because
 > I had made a mistake and becuase there was a newer driver in 2.4,

 Someone else did exactly the same thing you did, and somehow
 Linus picked it up that time.  Anyway, its backed out now,
 so its a moot point.
 
 > 	Maybe you were thinking of some other event when you
 > said "I believe changes to NCR53c80 were recently reverted back because
 > these 'fixes' lead to massive data corruption."  If so, I would be
 > interested in hearing about it.

 The data corruption issue was the lack of fixed locking and
 assorted fixes that Alan did after the 2.4/2.5 split.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
