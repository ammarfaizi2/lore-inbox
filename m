Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbTADTpZ>; Sat, 4 Jan 2003 14:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbTADTpZ>; Sat, 4 Jan 2003 14:45:25 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62080
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261337AbTADTpY>; Sat, 4 Jan 2003 14:45:24 -0500
Subject: Re: Kernel panic in 2.4.20-rc2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Speck <Thomas.Speck@wanadoo.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0301041544310.1106-100000@ThS-home.dyns.net>
References: <Pine.LNX.4.21.0301041544310.1106-100000@ThS-home.dyns.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041712663.2036.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 04 Jan 2003 20:37:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-04 at 14:56, Thomas Speck wrote:
> Hi,
> from time to time (frequency a couple of weeks) I get the following: 
> 
> Jan  4 15:32:19 ThS-home kernel: CPU 0: Machine Check 
> Exception: 0000000000000004
> Jan  4 15:32:19 ThS-home kernel: Bank 1: f200000000000115
> Jan  4 15:32:19 ThS-home kernel: Kernel panic: CPU context corrupt
> 
> Is that a hardware problem ? 

99 times out of 100 yes. The processor raised an internal hardware trap
Typically these come from processor or cache error. It can be something
as mundane as a CPU fan problem.

