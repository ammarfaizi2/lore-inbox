Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267468AbTAGSc6>; Tue, 7 Jan 2003 13:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267469AbTAGSc6>; Tue, 7 Jan 2003 13:32:58 -0500
Received: from smtp.mailix.net ([216.148.213.132]:36317 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id <S267468AbTAGSc5>;
	Tue, 7 Jan 2003 13:32:57 -0500
Date: Tue, 7 Jan 2003 19:41:31 +0100
From: Alex Riesen <fork0@users.sf.net>
To: Dirk Bull <dirkbull102@hotmail.com>
Cc: doug@mcnaught.org, linux-kernel@vger.kernel.org
Subject: Re: shmat problem
Message-ID: <20030107184131.GA382@steel>
Reply-To: Alex Riesen <fork0@users.sf.net>
References: <F39ekoL0jfQnPEiuGHi0001ee0c@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F39ekoL0jfQnPEiuGHi0001ee0c@hotmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dirk Bull, Tue, Jan 07, 2003 09:14:17 +0100:
> saved me a lot of time. Finally, in the code they share pages, therefor 
> using SHM_REMAP is not that unsafe, but still not good practice?

it seems correctly implemented, but the approach is error-prone
(Doug McNaught pointed on that).
What would you do if pagesize change? Fixing the code again
maybe a painful way, if the remapping was made to a common
practice.

-alex
