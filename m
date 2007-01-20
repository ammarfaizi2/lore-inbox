Return-Path: <linux-kernel-owner+w=401wt.eu-S965340AbXATSHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965340AbXATSHw (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 13:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965341AbXATSHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 13:07:52 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:29762 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965340AbXATSHw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 13:07:52 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UvN625uWYR3Dzuf6OZVv3B87x3h6QJHenlhzgicEgBE0VMBuI+NAOazvaXcjH7APziSlNzZgNQRL5jFMsH7n4zySO0oJ5Qko/+HCixwBLzObgWZ5NK1TGfUigrwBwfXYQszImjioMonHmLZEhaad0hibF0NCwid17kbrOsrmfAk=
Message-ID: <c384c5ea0701201007t4e637b9eh133101286ce5598d@mail.gmail.com>
Date: Sat, 20 Jan 2007 19:07:51 +0100
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: KB->KiB, MB -> MiB, ... (IEC 60027-2)
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEIPBAAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200701200908.47654.Michal.Kudla@gmail.com>
	 <MDEHLPKNGKAHNMBLJOLKMEIPBAAC.davids@webmaster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 1/20/07, David Schwartz <davids@webmaster.com> wrote:
>
> > [1.] One line summary of the problem:
> > KB->KiB, MB -> MiB, ... (IEC 60027-2 Letter symbols to be used in
> > electrical
> > technology – Part 2)
> > Should be everywere KiB, MiB, GiB, ... according to IEC 60027-2
>
>         Bytes are not an SI unit. A "megabyte" doesn't have to be a million bytes any more than a "megaphone" has to be a million phones. A "megabyte" is 1,048,576 bytes. The "mega" in there is not an SI prefix. "Mega" is only an SI prefix when it appears before an SI unit.
>
Nice observation, however, it still leaves quite an amount of internal
inconsistencies in the kernel output.

One way of getting rid of those inconsistencies would be to follow IEC
60027-2 for those cases where SI is inappropriate.

Leon.
