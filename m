Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbTKZTu5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 14:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264311AbTKZTu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 14:50:57 -0500
Received: from holomorphy.com ([199.26.172.102]:19902 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264310AbTKZTu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 14:50:56 -0500
Date: Wed, 26 Nov 2003 11:50:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: amanda vs 2.6
Message-ID: <20031126195049.GT8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <200311261212.10166.gene.heskett@verizon.net> <200311261415.52304.gene.heskett@verizon.net> <20031126193059.GS8039@holomorphy.com> <200311261443.43695.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311261443.43695.gene.heskett@verizon.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 November 2003 14:30, William Lee Irwin III wrote:
>> Sounds like trouble. Are there any external signs of what's going
>> on? e.g. is the disk thrashing?

On Wed, Nov 26, 2003 at 02:43:43PM -0500, Gene Heskett wrote:
> No, it just hangs forever on the su command, never coming back.  
> everything else I tried, which wasn't much, seemed to keep on working 
> as I sent that message with that hung su process in another shell on 
> another window.  I'm an idiot, normally running as root...
> I've rebooted, not knowing if an echo 0 to that variable would fix it 
> or not, I see after the reboot the default value is 0 now.

Okay, then we need to figure out what the hung process was doing.
Can you find its pid and check /proc/$PID/wchan?


-- wli
