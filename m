Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbSJCSWx>; Thu, 3 Oct 2002 14:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261276AbSJCSWx>; Thu, 3 Oct 2002 14:22:53 -0400
Received: from magic.adaptec.com ([208.236.45.80]:10372 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S261268AbSJCSWw>; Thu, 3 Oct 2002 14:22:52 -0400
Date: Thu, 03 Oct 2002 12:24:03 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Eriksson Stig <stig.eriksson@sweco.se>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: aic7xxx problems?
Message-ID: <367452704.1033669443@aslan.btc.adaptec.com>
In-Reply-To: <E50A0EFD91DBD211B9E40008C75B6CCA01497EDE@ES-STH-012>
References: <E50A0EFD91DBD211B9E40008C75B6CCA01497EDE@ES-STH-012>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Actually, in reviewing your message more fully, the problem is that
>> the timeout for the rewind operation is too short for your 
>> configuration.
>> The timeout should go away if you bump up the timeout in the st driver
>> so that your tape drive can rewind in peace.
> 
> The rewind is not *that* long, about 60 seconds...

Well, we are still waiting on the drive to do something, so its not
the aic7xxx driver's fault.

--
Justin
