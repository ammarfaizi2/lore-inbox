Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313911AbSEUM0W>; Tue, 21 May 2002 08:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSEUM0V>; Tue, 21 May 2002 08:26:21 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:21501 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S313911AbSEUM0S>; Tue, 21 May 2002 08:26:18 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E79B8AB303080F4096068F046CD1D89B934C94@exchange1.FalconStor.Net> 
To: Ron Niles <Ron.Niles@falconstor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops from local semaphore race condition 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 21 May 2002 13:26:14 +0100
Message-ID: <21563.1021983974@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ron.Niles@falconstor.com said:
> Then I realized it can possibly go corrupt, due to a race condition
> which lets down() continue before up() is complete:

This is what completions were added for.

--
dwmw2


