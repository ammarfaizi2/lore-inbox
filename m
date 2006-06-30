Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWF3QH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWF3QH4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 12:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWF3QH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 12:07:56 -0400
Received: from outbound-mail-07.bluehost.com ([67.138.240.207]:42884 "HELO
	outbound-mail-07.bluehost.com") by vger.kernel.org with SMTP
	id S1751348AbWF3QH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 12:07:56 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: "Robert Nagy" <robert.nagy@gmail.com>
Subject: Re: Intel RAID Controller SRCU42X in SGI Altix 350
Date: Fri, 30 Jun 2006 09:07:53 -0700
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <39f633820606290818g1978866ap@mail.gmail.com> <200606291217.00040.jbarnes@virtuousgeek.org> <39f633820606300144h21671f1agafb55d9972b9e40f@mail.gmail.com>
In-Reply-To: <39f633820606300144h21671f1agafb55d9972b9e40f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606300907.53880.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 71.198.43.183 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 30, 2006 1:44 am, Robert Nagy wrote:
> I know that it only works in EFI context. But I haven't seen the disk
> attached to it. I am going to try forcing it to PCI mode.

Ah ok, just as a sanity check?  It's been awhile since I looked at the 
EFI driver API, it could very well have problems on a machine like Altix 
due to memory mapping constraints and such.

Jesse
