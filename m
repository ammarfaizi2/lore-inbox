Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946364AbWKABzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946364AbWKABzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 20:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946369AbWKABzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 20:55:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:39786 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946364AbWKABzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 20:55:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zd5MAIVdNvBEySsRRH331VidE8kSVZ2022IhCTTm58WneYqkguF4WilCOgaeQUy7wRVC8Z/XeSs29+7PilshWAJysDaQLSyiAffomj8HHNvmwoz6yIINRnV7USbZsvzP6gKH1ZaNUG8t+sdsbhFVmo0smrCf+swYLloFvuyouis=
Message-ID: <d512a4f30610311755g11054e88w36f35e93205722a7@mail.gmail.com>
Date: Wed, 1 Nov 2006 02:55:18 +0100
From: "Sylvain Bertrand" <sylvain.bertrand@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [Bugme-new] [Bug 7437] New: VIA VT8233 seems to suffer from the via latency quirk
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Chris Wedgwood" <cw@f00f.org>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>
In-Reply-To: <20061031034342.GC11944@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610310020.k9V0KGQK003237@fire-2.osdl.org>
	 <20061030163458.4fb8cee1.akpm@osdl.org>
	 <d512a4f30610301703r68dfa848s116475b68435f136@mail.gmail.com>
	 <20061031034342.GC11944@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I enabled the via latency quirk code for my chipset and my workstation
does crash the same way.
Then, my crash problem seems not related to this quirk even if
symptoms are quite similar.

2006/10/31, Greg KH <greg@kroah.com>:
> That would be the best way to proceed.  If you add your device ids to
> the quirk, does the machine work properly afterward?
>
> thanks,
>
> greg k-h
