Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030409AbWEKSD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbWEKSD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 14:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWEKSD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 14:03:56 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:4287 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030408AbWEKSDz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 14:03:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hRldV333m+p38MbGSYPcEKnVyWnd1QRQWVBdGPyZbGRC3X8Qt7yCJfeRuZHpxNYnHsqLTbPfx9vd1xcujaH003amyRYW8/3OMKyzxCnwbYyZ5XFPfABPYGFrrn3XkHNaEIxsjXCyh1eU6gQUUorFeZEivTBHrgec0ThCYs848nY=
Message-ID: <bda6d13a0605111103x6884e2c8na69765f671574eab@mail.gmail.com>
Date: Thu, 11 May 2006 11:03:53 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: "Mario Ohnewald" <mario@bortal.de>, linux-kernel@vger.kernel.org
Subject: Re: can not mount compact flash drive hda (ext3) with 2.6.16
In-Reply-To: <1147370330.6999.13.camel@spiekey.spiekey>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1147370330.6999.13.camel@spiekey.spiekey>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try running

$ grep /dev/hda /etc/mtab
$ grep /dev/hda /proc/mounts

The errors from mkfs.ext3 would normally indicate a line containing
/dev/hda in /etc/mtab.
