Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267740AbUI1NrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267740AbUI1NrP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 09:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267743AbUI1NrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 09:47:15 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:42002 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S267740AbUI1NrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 09:47:09 -0400
Date: Tue, 28 Sep 2004 14:47:05 +0100
From: Dave Jones <davej@redhat.com>
To: Brian McGrew <Brian@doubledimension.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Probing for System Model Information
Message-ID: <20040928134705.GA11916@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Brian McGrew <Brian@doubledimension.com>,
	linux-kernel@vger.kernel.org
References: <E6456D527ABC5B4DBD1119A9FB461E35019377@constellation.doubledimension.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E6456D527ABC5B4DBD1119A9FB461E35019377@constellation.doubledimension.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 06:32:31AM -0700, Brian McGrew wrote:
 > Good morning All!
 > 
 > We exclusively ship Dell boxes with our hardware.  However, we use several different models, 1400's, 1600's, 2350's, 4600's and so on.  I need to write a small program to probe the system for the model information since I don't seem to find it in the logs anywhere.  
 > 
 > I know the model info is in there somewhere and it's accessible because if I look on the default factory installed version of Windows, it's listed.
 > 
 > Does anyone know how to do this or can you point me to one that's already done or some samples?
 
You can find this info in the DMI tables assuming Dell filled
them in with sensible data (which they usually do).

dmidecode will read these tables from userspace.

		Dave
