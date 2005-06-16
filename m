Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVFPLrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVFPLrI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 07:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVFPLrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 07:47:08 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:53650 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S261616AbVFPLqz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 07:46:55 -0400
Message-ID: <42B1681B.6000703@aitel.hist.no>
Date: Thu, 16 Jun 2005 13:52:59 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: "Theodore Ts'o" <tytso@mit.edu>, Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>,
       Andreas Dilger <adilger@clusterfs.com>, fs <fs@ercist.iscas.ac.cn>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, zhiming@admin.iscas.ac.cn,
       qufuping@ercist.iscas.ac.cn, madsys@ercist.iscas.ac.cn,
       xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, okuyama@intellilink.co.jp,
       matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
       fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
       takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
       ext2-devel@lists.sourceforge.net, shaggy@austin.ibm.com,
       xfs-masters@oss.sgi.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [Ext2-devel] Re: [RFD] FS behavior (I/O failure) in kernel summit
References: <1118692436.2512.157.camel@CoolQ> <42ADC99D.5000801@namesys.com> <20050613201315.GC19319@moraine.clusterfs.com> <42AE1D4A.3030504@namesys.com> <42AE450C.5020908@dd.iij4u.or.jp> <20050615140105.GE4228@thunk.org> <42B091E3.3010908@namesys.com>
In-Reply-To: <42B091E3.3010908@namesys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

>What users need is for a window to pop up saying "the usb drive is
>turned off" or "we are getting checksum errors from XXX, this may
>indicate hardware problems that require your attention".
>  
>
Nice.  And the way to do this right is to have the kernel merely
log the error as usual.  The user can have some daemon listening
to the log, this program may then pop up error messages with
nifty detailed explanations, start up diagnostic software
for various subsystems and so on. 

The kernel can't do GUI stuff - a GUI may or may not be present,
and the kernel cannot know.  The server may not run X at all
but I still run graphical SW on it using a workstation or X-terminal.
Or the pc may have three video cards, each running a different xserver
with different users for each.  Who to report to?

An error-reporting daemon have an easier job, it can look up the
correct (possibly remote) display in its config file for all those
cases when there isn't just _one_ display.

Helge Hafting




