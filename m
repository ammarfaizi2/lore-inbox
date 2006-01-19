Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbWASBWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbWASBWe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 20:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWASBWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 20:22:33 -0500
Received: from [220.248.27.114] ([220.248.27.114]:10420 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S932522AbWASBWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 20:22:32 -0500
Date: Thu, 19 Jan 2006 08:57:53 +0800
From: hugang@soulinfo.com
To: Nagaprabhanjan Bellari <nagp.lists@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Target mode drivers
Message-ID: <20060119005753.GB17765@hugang.soulinfo.com>
References: <43CE2344.2090503@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CE2344.2090503@gmail.com>
User-Agent: Mutt/1.5.11
X-Virus-Checked: Checked
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 04:45:16PM +0530, Nagaprabhanjan Bellari wrote:
> Hi,
> 
> Does anybody know of any SCSI target mode drivers (for HBAs) available 
> open source?
> 
> Please let me know.

SCSI target mode for linux
http://scst.sf.net/

I has been works on some scsi hba to enable target mode in linux, here
is some source code for it. currently we support 

QLOGIC ISP base
  1040
  23xx
 
Adaptec 
  160 base card seem work well.
  320 base card can't works right now.

LSI 
  all MPT base including the FC and SAS, but the SCSI interface has not test
  passed.

http://bj.soulinfo.com/~hugang/scst/tgt/

-- 
   .-.      .-.    _              
   : :      : :   :_;             
 .-' : .--. : `-. .-. .--.  ,-.,-.
' .; :' '_.'' .; :: :' .; ; : ,. :
`.__.'`.__.'`.__.':_;`.__,_;:_;:_;

Hu Gang
