Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVDAPa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVDAPa1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 10:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbVDAPa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 10:30:26 -0500
Received: from icecream.egps.com ([38.119.130.6]:44038 "EHLO mail.egps.com")
	by vger.kernel.org with ESMTP id S261758AbVDAP2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 10:28:47 -0500
Date: Fri, 1 Apr 2005 10:28:46 -0500
From: Nachman Yaakov Ziskind <awacs@ziskind.us>
To: Burton Windle <bwindle@fint.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Slow SCSI perf in RH 7.3
Message-ID: <20050401102846.A24623@egps.egps.com>
Reply-To: awacs@ziskind.us
References: <20050330174828.B27631@egps.egps.com> <Pine.LNX.4.62.0503301758400.1159@morpheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503301758400.1159@morpheus>
User-Agent: Mutt/1.3.23i
X-Mailer: Outlook stinks. Dump Outlook.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burton Windle wrote (on Wed, Mar 30, 2005 at 06:01:21PM -0500):
> On Wed, 30 Mar 2005, Nachman Yaakov Ziskind wrote:
> 
> >I have a server:
> >2.4.20-28.7 #1 Thu Dec 18 11:31:59 EST 2003 i686
> >
> 
> Looking at the output of 'top' may be helpful, as it will show if the 
> system is CPU or IO bound. However, plese note that 2.4.20 is quite old 
> (November of 2002), and contains numerous security holes. Upgrading to 
> something more recent, like 2.4.29, may be a good first start.

Thanks for the quick reply. Sar seems to indicate that the server is 
disk-bound (although some swapping is going on, so more RAM is on the way). 
CPU is idle, consistently, 99% of the time. 

Would upgrading the kernel help the disk performance? Server is not 
connected to the internet, so security concerns are not *that* important, 
but performance is ...

-- 
_________________________________________
Nachman Yaakov Ziskind, FSPA, LLM       awacs@ziskind.us
Attorney and Counselor-at-Law           http://ziskind.us
Economic Group Pension Services         http://egps.com
Actuaries and Employee Benefit Consultants
