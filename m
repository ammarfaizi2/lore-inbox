Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVFNN7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVFNN7W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 09:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVFNN7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 09:59:22 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:2028 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261211AbVFNN7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 09:59:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sm3m4R+M4D5EDJJz7WGsIH3TzNTOoOgDRe0ZgHy83jY3DtXEiOSQCXNHY021ySWI/gphoMeeL1U0Mg9FvpdQzvm5rH+2JE5G3ENODRrO9czsW00dYPZOfUQ32zTT3al9RoMedPi7TQpCeDd8vKwCEYTiclUWMzJ1DTWjHZNsiSo=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Brian Marete <bgmarete@gmail.com>
Subject: Re: PROBLEM: Kernel oops accompanied by complete system lock-up.
Date: Tue, 14 Jun 2005 18:04:45 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <6dd519ae05061406222d60c6bc@mail.gmail.com>
In-Reply-To: <6dd519ae05061406222d60c6bc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506141804.46316.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 June 2005 17:22, Brian Marete wrote:

> 3. KERNEL VERSION (/proc/version): Linux version 2.6.11-debug

> Jun 11 05:20:18 gamma kernel: EIP:    0060:[del_timer+97/176]    Tainted: P      VLI
> Jun 11 05:20:18 gamma kernel: EIP:    0060:[<c01235f1>]    Tainted: P      VLI

> * My kernel is "tainted" by the module "slamr" which controls a
>   SmartLink "soft" modem. I compiled this propreitery module from a
>   Debian Source package: slmodem-2.9.9a.tar.gz

Care to reproduce with recent untainted kernel?
