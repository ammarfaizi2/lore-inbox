Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263191AbSJBRDb>; Wed, 2 Oct 2002 13:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263192AbSJBRDb>; Wed, 2 Oct 2002 13:03:31 -0400
Received: from magic.adaptec.com ([208.236.45.80]:40915 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S263191AbSJBRDa>; Wed, 2 Oct 2002 13:03:30 -0400
Date: Wed, 02 Oct 2002 11:08:43 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Eriksson Stig <stig.eriksson@sweco.se>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx problems?
Message-ID: <3901880000.1033578523@aslan.btc.adaptec.com>
In-Reply-To: <E50A0EFD91DBD211B9E40008C75B6CCA01497EDD@ES-STH-012>
References: <E50A0EFD91DBD211B9E40008C75B6CCA01497EDD@ES-STH-012>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi
> 
> Maybe You can help me out with this one...
> I have hp DLT connected to an adaptec SCSI board.

>From the perspective of the controller, the target has taken the
full command but has yet to REQ for either a cdb transfer retry
or a new phase.  This looks like a target problem or a cabling
problem that prevents the initiator from seeing a REQ or two.

--
Justin
