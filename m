Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWFMQ5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWFMQ5Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 12:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWFMQ5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 12:57:25 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:11391 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932143AbWFMQ5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 12:57:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XR2nAhuuqRTjtFkUGyP+47FS4+PyrMM4RFRvhO3s7BtYcDu14gMeARBWuaT8udxC4UDl+I2M+qGD26+mdAXwJnOq4HBCK0mfulY4DP2xGSWKhxKUPrq14PkpARPXdQ7dek05HPThSOtbKrEd+BFOJNCvPYQOfX/aGDI1KiqFziY=
Message-ID: <305c16960606130956ufa88de7y7c80ef6fa46ed257@mail.gmail.com>
Date: Tue, 13 Jun 2006 13:56:54 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: How does RAID work with IT8212 RAID PCI card?
Cc: "Christian H?rtwig" <christian.haertwig@gmx.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060613164427.GD560@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606131758.45704.christian.haertwig@gmx.de>
	 <20060613160138.GC560@csclub.uwaterloo.ca>
	 <305c16960606130920wa66c6bk504273a9a45e645e@mail.gmail.com>
	 <20060613164427.GD560@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/06, Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:
> On Tue, Jun 13, 2006 at 01:20:55PM -0300, Matheus Izvekov wrote:
> > No not true, i have this card and its a true hardware raid card. The
> > thing is, this card has both a raid and a passthru mode, you should
> > check which bios is flashed into it. Google is your friend.
>
> Hmm, you would think that if the bios lets you setup a raid, then it
> must have raid mode enabled then.  Or does it need a different driver to
> work then?
>
> Len Sorensen
>

Im not sre, never flashed the bios for passthru mode, because the
driver lets you select the mode thru some modparm. But maybe the
different bios only changes the default mode.
Anyway, this card is hardware raid for sure.
