Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269520AbTCDT0v>; Tue, 4 Mar 2003 14:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269521AbTCDT0v>; Tue, 4 Mar 2003 14:26:51 -0500
Received: from n010080.adsl.netland.nl ([217.170.46.123]:15250 "EHLO
	n010080.nbs.netland.nl") by vger.kernel.org with ESMTP
	id <S269520AbTCDT0s>; Tue, 4 Mar 2003 14:26:48 -0500
Message-ID: <3E650061.9050201@netland.nl>
Date: Tue, 04 Mar 2003 20:37:05 +0100
From: Ron Arts <raarts@netland.nl>
Reply-To: raarts@office.netland.nl
Organization: Netland Internet Services
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.3b) Gecko/20030302
X-Accept-Language: en, nl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, raarts@office.netland.nl,
       david.knierim@tekelec.com, alexander@netintact.se,
       Donald Becker <becker@scyld.com>, Greg KH <greg@kroah.com>,
       jamal <hadi@cyberus.ca>, Jeff Garzik <jgarzik@pobox.com>,
       kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
       Robert Olsson <Robert.Olsson@data.slu.se>
Subject: Re: PCI init issues
References: <Pine.LNX.4.44.0303041046370.1426-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0303041046370.1426-100000@home.transmeta.com>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms070907080106060704010009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms070907080106060704010009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> On Tue, 4 Mar 2003, Ivan Kokshaysky wrote:
> 
>>Indeed, looks like only pin 0 (INT_A of that card) is connected. :-(
> 
> 
> Well, I'd say it looks like the MP table _claims_ that only pin0 is 
> connected. Remember: the claim was that this machine worked on WinXP.
> 

Well, I submitted the dmseg and messages because Jamal requested
it (same motherboard, same 4-port card and same strange IRQ
assignments), but this particular machine is not tested with XP,
and I don't think we have that.
I think we still have a disk with Win2000 on it. Would that help?

Should have to wait until tomorrow though, I'm on Central European Time,
and the machine is located elsewhere.

Ron


> So there are at least two potential reasons for that:
> 
>  - The MP table is simply wrong, and WinXP gets the routing information 
>    from somewhere else (ie most likely ACPI)
> 
>  - The MP table is right, and only pin0 is connected, and WinXP only uses 
>    pin0 (ie it puts the card in some state where all irqs are shared 
>    across all of the four tulip chips).
> 
> Maybe somebody can come up with other schenarios.
> 
> It would be interesting to hear what "Device Manager" (or whatever it is
> called) unde WinXP claims the interrupts are on this machine... Are they
> all on irq 48 on XP too? Or has XP gotten magic knowledge somewhere
> (ACPI?) and they are on different irq's?
> 
> 		Linus


--------------ms070907080106060704010009
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJdjCC
AxkwggKCoAMCAQICAwdzkDANBgkqhkiG9w0BAQQFADCBkjELMAkGA1UEBhMCWkExFTATBgNV
BAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUx
HTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVl
bWFpbCBSU0EgMjAwMC44LjMwMB4XDTAyMDUxMzEyNDI0OFoXDTAzMDUxMzEyNDI0OFowXDEN
MAsGA1UEBBMEQXJ0czERMA8GA1UEKhMIUm9uIFIuQS4xFjAUBgNVBAMTDVJvbiBSLkEuIEFy
dHMxIDAeBgkqhkiG9w0BCQEWEXJhYXJ0c0BuZXRsYW5kLm5sMIIBIjANBgkqhkiG9w0BAQEF
AAOCAQ8AMIIBCgKCAQEAsz1vQDs+fOlea3WOBrQay1HHCqENWzUhuaMzDYKduzVxGzwNmc7j
HnR0QflErghjp61ihnDQI1EF3NbIlSAne3fiCQ/9i2Ztbtxa1dlhzu3iZzMvCX4MDaIFwgk1
rkdVG2sVZwgjV9nvroVZoV3Mqgh2ev7Cd6USxG9yJ3HFaK/BntOhCnRv52jTPOFqlZfD37FH
XNmllxdmdfD7VKE7ssTr+wq336cm2uqqY0BEiovD1W6gyG2UXDBRo7ExhCroJzzirmsffW09
p5XTdzC5CO3tdYqz5rtUua5ED0AwJGK7WO4YO2jHRSg7jykc+XvSXvL9SdlhKMqeWt1b/im+
XQIDAQABoy4wLDAcBgNVHREEFTATgRFyYWFydHNAbmV0bGFuZC5ubDAMBgNVHRMBAf8EAjAA
MA0GCSqGSIb3DQEBBAUAA4GBABNzXukOa8Lhmw1d12+RvwFORDhX2FEy+iaXkG6RDTcctEuc
QBAebt1ialWEa3MAI5R7xKhkF78W/RilmHbSMr5MX3RfSnmi49n0+rzqtXDygci1PJfZFLSi
cNx8GreiFF9H1id3F0LmJpkc2WEEJxJ5ofKVpXjjrt1MkMm2X8KtMIIDGTCCAoKgAwIBAgID
B3OQMA0GCSqGSIb3DQEBBAUAMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBD
YXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2Vy
dGlmaWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAw
LjguMzAwHhcNMDIwNTEzMTI0MjQ4WhcNMDMwNTEzMTI0MjQ4WjBcMQ0wCwYDVQQEEwRBcnRz
MREwDwYDVQQqEwhSb24gUi5BLjEWMBQGA1UEAxMNUm9uIFIuQS4gQXJ0czEgMB4GCSqGSIb3
DQEJARYRcmFhcnRzQG5ldGxhbmQubmwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQCzPW9AOz586V5rdY4GtBrLUccKoQ1bNSG5ozMNgp27NXEbPA2ZzuMedHRB+USuCGOnrWKG
cNAjUQXc1siVICd7d+IJD/2LZm1u3FrV2WHO7eJnMy8JfgwNogXCCTWuR1UbaxVnCCNX2e+u
hVmhXcyqCHZ6/sJ3pRLEb3InccVor8Ge06EKdG/naNM84WqVl8PfsUdc2aWXF2Z18PtUoTuy
xOv7Crffpyba6qpjQESKi8PVbqDIbZRcMFGjsTGEKugnPOKuax99bT2nldN3MLkI7e11irPm
u1S5rkQPQDAkYrtY7hg7aMdFKDuPKRz5e9Je8v1J2WEoyp5a3Vv+Kb5dAgMBAAGjLjAsMBwG
A1UdEQQVMBOBEXJhYXJ0c0BuZXRsYW5kLm5sMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEE
BQADgYEAE3Ne6Q5rwuGbDV3Xb5G/AU5EOFfYUTL6JpeQbpENNxy0S5xAEB5u3WJqVYRrcwAj
lHvEqGQXvxb9GKWYdtIyvkxfdF9KeaLj2fT6vOq1cPKByLU8l9kUtKJw3Hwat6IUX0fWJ3cX
QuYmmRzZYQQnEnmh8pWleOOu3UyQybZfwq0wggM4MIICoaADAgECAhBmRXK3zHT1z2N2RYTQ
LpEBMA0GCSqGSIb3DQEBBAUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBD
YXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5nMSgw
JgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtUaGF3
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
zqH2AAAAAAAA
--------------ms070907080106060704010009--

