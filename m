Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUDHHli (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 03:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbUDHHli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 03:41:38 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:34825 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262009AbUDHHlh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 03:41:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Dhruv Gami <gami@d10systems.com>, linux-kernel@vger.kernel.org
Subject: Re: setgid - its current use
Date: Thu, 8 Apr 2004 10:41:24 +0300
X-Mailer: KMail [version 1.4]
References: <Pine.LNX.4.58.0404072140070.14350@d10systems.homelinux.com>
In-Reply-To: <Pine.LNX.4.58.0404072140070.14350@d10systems.homelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200404081041.25006.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 April 2004 04:46, Dhruv Gami wrote:
> Hello Everyone,
>
> A long time back there was discussion over setuid/setgid and how its been
> replaced by Capabilities (This is what i understood from the
> archives...please correct me if im wrong).
>
> I'd like to know the possibility of using setgid for users to switch their
> groups and work as a member of a particular group. Essentially, if i want
> one user, who belongs to groups X, Y and Z to create a file as a member of
> group Y while he's logged on as a member of group X, would it be possible
> through setgid() ?

it is possible through chmod
-- 
vda
