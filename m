Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTJ2Wpb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 17:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbTJ2Wpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 17:45:31 -0500
Received: from codepoet.org ([166.70.99.138]:18401 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S261928AbTJ2Wp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 17:45:28 -0500
Date: Wed, 29 Oct 2003 15:45:12 -0700
From: Erik Andersen <andersen@codepoet.org>
To: "?$BB-N)Ao" <adachi@aa.ap.titech.ac.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A harmless problem  in the IDE driver (linux-2.4.22)
Message-ID: <20031029224512.GB32463@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"?$BB-N)Ao" <adachi@aa.ap.titech.ac.jp>, linux-kernel@vger.kernel.org
References: <B8DC3168-09EF-11D8-83B0-003065E04568@aa.ap.titech.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8DC3168-09EF-11D8-83B0-003065E04568@aa.ap.titech.ac.jp>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Oct 29, 2003 at 06:10:21PM +0900, ?$BB-N)Ao wrote:
> It is clear from this part that the function
> idedisk_read_native_max_address() is called always if the function
> init_idedisk_capacity() is called. This makes the error message

I sent in a fix for this a while ago.  My patch was incorporated
into 2.6.x, but my patch for the same problem in 2.4.x was ignored.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
