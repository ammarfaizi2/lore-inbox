Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946154AbWJSQGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946154AbWJSQGO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946156AbWJSQGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:06:13 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:25115 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1946154AbWJSQGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:06:12 -0400
Message-ID: <4537A263.4090601@freenet.de>
Date: Thu, 19 Oct 2006 18:05:55 +0200
From: Carsten Otte <cotte@freenet.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Cedric Le Goater <clg@fr.ibm.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Gabriel C <nix.or.die@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm1
References: <20061016230645.fed53c5b.akpm@osdl.org>	<45367210.4040507@googlemail.com>	<200610182118.31371.rjw@sisk.pl>	<4536818E.3060505@fr.ibm.com>	<453683A6.9090106@yahoo.com.au>	<45368E0A.1030503@fr.ibm.com> <20061018152346.0486b6bc.akpm@osdl.org>
In-Reply-To: <20061018152346.0486b6bc.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> The page we're writing into isn't locked, so there's no deadlock afaict.
>
> But then, I forget how xip works.  Carsten, is it actually being used for
> anything?
>   
The comment may be superfluous. I did not quite understand the deadlock 
condition refered to by the comment in filemap, therefore I cut&pasted 
it over. I will send a patch that removes it.

Carsten

