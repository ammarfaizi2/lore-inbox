Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932337AbWFEAGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWFEAGf (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 20:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWFEAGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 20:06:35 -0400
Received: from wx-out-0102.google.com ([66.249.82.204]:63023 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932337AbWFEAGf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 20:06:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=YNK9foOTuw4trxbq2ssKXG3yAzMOe7hkGgr9gNq0XSfMGU+ghhNHDw2DldY1BS9WMpo6J3b0MrFTse+9/fKFi7RGH0WvPG0SpfEcB0wubVVZNsR+bWhUdgmbQh8mu9U13E00YRpqWtkLe+c5XdGtPO32fnwe+nDA4U6JDXHQj1s=
Message-ID: <986ed62e0606041706o4cc950d1t843b52422f0ec523@mail.gmail.com>
Date: Sun, 4 Jun 2006 17:06:34 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "=?ISO-8859-1?Q?J.A._Magall=F3n?=" <jamagallon@ono.com>
Subject: Re: 2.6.17-rc5-mm3
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060605012842.3d58095f@werewolf.auna.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	 <20060605012842.3d58095f@werewolf.auna.net>
X-Google-Sender-Auth: 2e05560b97133c80
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/06, J.A. Magallón <jamagallon@ono.com> wrote:
> Jun  2 14:34:39 annwn kernel: --------------------------------------------------------
> Jun  2 14:34:39 annwn kernel: 141 out of 206 testcases failed, as expected. |
> Jun  2 14:34:39 annwn kernel: ----------------------------------------------------
>
> Expected ? Uh ?

grep PROVE .config

Make sure all 4 of them are set to Y; if any of them are N, then test
case failures would in fact be expected.
-- 
-Barry K. Nathan <barryn@pobox.com>
