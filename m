Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293302AbSCFHsn>; Wed, 6 Mar 2002 02:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293303AbSCFHsd>; Wed, 6 Mar 2002 02:48:33 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:23542
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293302AbSCFHs3>; Wed, 6 Mar 2002 02:48:29 -0500
Date: Tue, 5 Mar 2002 23:49:08 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Michael Cheung <vividy@justware.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mount -o remount,ro cause error "device is busy"
Message-ID: <20020306074908.GA342@matchmail.com>
Mail-Followup-To: Michael Cheung <vividy@justware.co.jp>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020306161900.C897.VIVIDY@justware.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020306161900.C897.VIVIDY@justware.co.jp>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002 at 04:40:10PM +0900, Michael Cheung wrote:
> hi, all;
> 	I have upgraded my kernel to version 2.4.
> And i have tested 2.4.16 and 2.4.18. Both of these
> two version have the same problem when system reboot.
> "/: device is busy";
> in shutdown script:
> umount -a
> mount -n -o ro,remount /
> these two line result error: device is busy.
> 

We need more info about your config.  Do you have any patches in this
kernel?  What modules have been loaded?  Highmem?  x86?  drive controller?
drive? ram size? lspci output, etc...
