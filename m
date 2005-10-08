Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVJHX7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVJHX7N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 19:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVJHX7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 19:59:13 -0400
Received: from xproxy.gmail.com ([66.249.82.196]:3636 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932108AbVJHX7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 19:59:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=qochgKoTzmL6PhLLrJKc6nmbdlsgV/rC9IhkOf6ow0gj4TQxqsSa/C66yDcd0Prbw3fFYsO6DpftUktmRjTQeymHQUYDgLm0LFdqxIFen8leqjhBm858KSvxhG4w5KtEU3GUhbjerSb4fRmBuxDCiivDKnBA93jZLbBGh709Vtw=
Message-ID: <5bdc1c8b0510081659j3235063bi49e8251b1e4f7a7c@mail.gmail.com>
Date: Sat, 8 Oct 2005 16:59:12 -0700
From: Mark Knecht <markknecht@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt13 build problem (Invoked `ld.so')
Cc: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <5bdc1c8b0510081524g56a328f9ubad8a73bf6cd60d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4370_31895405.1128815952127"
References: <5bdc1c8b0510081524g56a328f9ubad8a73bf6cd60d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_4370_31895405.1128815952127
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Attaching .config

On 10/8/05, Mark Knecht <markknecht@gmail.com> wrote:
> Hi,
>    I've been quietly working here on my xrun issues. They are getting
> better with every kernel. I'm down to just a few a day now. However I
> am pretty reliably able to create at least one the first time I start
> up Firefox and browse the web. For this reason I thought I'd try
> learning to get some latency traces.
>
> 1) I built 2.6.14-rc3-rt13. It ran fine.
>
> 2) I built 2.6.14-rc3-rt13 with 'Debug Preemptible kernel' enabled. I
> get a message boot time warning me that the option is on, but the
> kernel boots and runs fine.
>
> 3) I then tried to 2.6.14-rc3-rt13 again as above but I added
> 'Non-preemptible critical section latency timing'. The compile failed.
> This is what's in my terminal:
>
>   CC      drivers/acpi/utilities/utobject.o
>   CC      drivers/acpi/utilities/utstate.o
>   CC      drivers/acpi/utilities/utmutex.o
>   CC      drivers/acpi/utilities/utcache.o
> Usage: ld.so [OPTION]... EXECUTABLE-FILE [ARGS-FOR-PROGRAM...]
> You have invoked `ld.so', the helper program for shared library executabl=
es.
> This program usually lives in the file `/lib/ld.so', and special directiv=
es
> in executable files using ELF shared libraries tell the system's program
> loader to load the helper program from this file.  This helper program lo=
ads
> the shared libraries needed by the program executable, prepares the progr=
am
> to run, and runs it.  You may invoke this helper program directly from th=
e
> command line to load and run an ELF executable file; this is like executi=
ng
> that file itself, but always uses this helper program from the file you
> specified, instead of the helper program file specified in the executable
> file you run.  This is mostly of use for maintainers to test new versions
> of this helper program; chances are you did not intend to run this progra=
m.
>
>   --list                list all dependencies and how they are resolved
>   --verify              verify that given object really is a dynamically =
linked
>                         object we can handle
>   --library-path PATH   use given PATH instead of content of the environm=
ent
>                         variable LD_LIBRARY_PATH
>   --inhibit-rpath LIST  ignore RUNPATH and RPATH information in object na=
mes
>                         in LIST
> make[3]: *** [drivers/acpi/utilities/utcache.o] Error 2
> make[2]: *** [drivers/acpi/utilities] Error 2
> make[1]: *** [drivers/acpi] Error 2
> make: *** [drivers] Error 2
> lightning linux #
>
>    Let me know how to proceed.
>
> Thanks,
> Mark
>

------=_Part_4370_31895405.1128815952127
Content-Type: application/x-bzip2; name="knecht.config-2.6.14-rc3-rt13.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="knecht.config-2.6.14-rc3-rt13.bz2"

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
8Z9vufazc530c0DZIatZQE/8XckU4UJCLYGlDA==
------=_Part_4370_31895405.1128815952127--
