Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbTERGjQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 02:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbTERGjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 02:39:16 -0400
Received: from 72.1-182-adsl-pool.axelero.hu ([81.182.1.72]:43280 "EHLO
	server.leva.2y.net") by vger.kernel.org with ESMTP id S261161AbTERGjO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 02:39:14 -0400
Message-ID: <3EC72D6F.1070007@ecentrum.hu>
Date: Sun, 18 May 2003 08:51:27 +0200
From: LeVA <leva@ecentrum.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: hu, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: usb keyboard problem.
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms020801030308020503050104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms020801030308020503050104
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

I have an usb keyboard, and it has some extra keys (internet keys, 
multimedia keys).
If I use the keyboard in ps/2 port, all of those extra buttons work, 
because I can bind the extra keys's keycodes in a hotkeys program.
If I use the keyboard in the usb port, some of the extra keys don't 
work. In plain console, if I push some of the "non-working" extra 
buttons, I get these error messages:

   keyboard.c: can't emulate rawmode for keycode 259
   keyboard.c: can't emulate rawmode for keycode 259

The problem is, that I can not bind keycode 259 in X, because it only 
works for keycodes between 8 - 255. But when I use the keyboard in the 
usb port, I get too high keycodes like (see above) 259, which I can not use.
I (fortunately) have a few working internet buttons. If I press those in 
plain console, I get these messages:

   keyboard: unknown scancode e0 66

I don't think this is an error, because that key, which "produces" the 
"keyboard: unknown scancode e0 66" message, works under X, and can be 
binded to an action.

Is there any chance to make the keyboard work similarly in the ps/2 and 
the usb port?

Please try to help me with this problem, I'm already through the 
xfree86-list, and the debian-user list, but nobody could help me.

Thanks!

Levai Daniel



--------------ms020801030308020503050104
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIHrjCC
A9MwggM8oAMCAQICDwD+3QAAAAKuKcGCUoQXCTANBgkqhkiG9w0BAQQFADCBvDELMAkGA1UE
BhMCREUxEDAOBgNVBAgTB0hhbWJ1cmcxEDAOBgNVBAcTB0hhbWJ1cmcxOjA4BgNVBAoTMVRD
IFRydXN0Q2VudGVyIGZvciBTZWN1cml0eSBpbiBEYXRhIE5ldHdvcmtzIEdtYkgxIjAgBgNV
BAsTGVRDIFRydXN0Q2VudGVyIENsYXNzIDEgQ0ExKTAnBgkqhkiG9w0BCQEWGmNlcnRpZmlj
YXRlQHRydXN0Y2VudGVyLmRlMB4XDTAyMDkwOTExMzQwMloXDTAzMDkwOTExMzQwMlowRTEL
MAkGA1UEBhMCSFUxFTATBgNVBAMTDExldmFpIERhbmllbDEfMB0GCSqGSIb3DQEJARYQbGV2
YUBlY2VudHJ1bS5odTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAPOUPPQHTife
GH6YgDYR6Z/AkWuxVDVVxlZEgE5ahMNqES9HISHlT9lunbffFozjsJZa6eS7FYmAywSC3X/G
hyEj4/FDYmm5nRtpSEXuBXaeY/yEk/pFo95qoiIDt5bKqLb4pwAfR7f/qJrdm1qdjq7cAp12
La5kJdRjb2Lh0xLUvd65v0bGVJZSnqxdwDv13DEyPZJgcJ/bAUzc417uwa4yWxwov1UfOoCs
A+GduNAnSYI0HawXlKjl6GZb1g5XISI9U7GlN5yAkAf38bulYBuyMNnJVBTtnENL3MciegJd
zfBRx58p0hTNcGVIIGw1e9MlJsWF4fJSovTttlz8scECAwEAAaOByDCBxTAMBgNVHRMBAf8E
AjAAMA4GA1UdDwEB/wQEAwIF4DAzBglghkgBhvhCAQgEJhYkaHR0cDovL3d3dy50cnVzdGNl
bnRlci5kZS9ndWlkZWxpbmVzMBEGCWCGSAGG+EIBAQQEAwIFoDBdBglghkgBhvhCAQMEUBZO
aHR0cHM6Ly93d3cudHJ1c3RjZW50ZXIuZGUvY2dpLWJpbi9jaGVjay1yZXYuY2dpL0ZFREQw
MDAwMDAwMkFFMjlDMTgyNTI4NDE3MDk/MA0GCSqGSIb3DQEBBAUAA4GBABl6MQT2mp/Va1Ng
Q8vLKZ0Qqa25gWy4gPS04ZVzjcu+XmbWbjAJ+WoY+Md1kGh3RncBTJ5ICpiGNkueGVBb/0zt
w5eWH6Y5ZiJrG59jfY1FDLLC0Y2iqt9seHVjcxjFaGozWOnakkDoVoS6++WNen0G0RMiHkZo
sW/P/jYEn0cUMIID0zCCAzygAwIBAgIPAP7dAAAAAq4pwYJShBcJMA0GCSqGSIb3DQEBBAUA
MIG8MQswCQYDVQQGEwJERTEQMA4GA1UECBMHSGFtYnVyZzEQMA4GA1UEBxMHSGFtYnVyZzE6
MDgGA1UEChMxVEMgVHJ1c3RDZW50ZXIgZm9yIFNlY3VyaXR5IGluIERhdGEgTmV0d29ya3Mg
R21iSDEiMCAGA1UECxMZVEMgVHJ1c3RDZW50ZXIgQ2xhc3MgMSBDQTEpMCcGCSqGSIb3DQEJ
ARYaY2VydGlmaWNhdGVAdHJ1c3RjZW50ZXIuZGUwHhcNMDIwOTA5MTEzNDAyWhcNMDMwOTA5
MTEzNDAyWjBFMQswCQYDVQQGEwJIVTEVMBMGA1UEAxMMTGV2YWkgRGFuaWVsMR8wHQYJKoZI
hvcNAQkBFhBsZXZhQGVjZW50cnVtLmh1MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEA85Q89AdOJ94YfpiANhHpn8CRa7FUNVXGVkSATlqEw2oRL0chIeVP2W6dt98WjOOwllrp
5LsViYDLBILdf8aHISPj8UNiabmdG2lIRe4Fdp5j/IST+kWj3mqiIgO3lsqotvinAB9Ht/+o
mt2bWp2OrtwCnXYtrmQl1GNvYuHTEtS93rm/RsZUllKerF3AO/XcMTI9kmBwn9sBTNzjXu7B
rjJbHCi/VR86gKwD4Z240CdJgjQdrBeUqOXoZlvWDlchIj1TsaU3nICQB/fxu6VgG7Iw2clU
FO2cQ0vcxyJ6Al3N8FHHnynSFM1wZUggbDV70yUmxYXh8lKi9O22XPyxwQIDAQABo4HIMIHF
MAwGA1UdEwEB/wQCMAAwDgYDVR0PAQH/BAQDAgXgMDMGCWCGSAGG+EIBCAQmFiRodHRwOi8v
d3d3LnRydXN0Y2VudGVyLmRlL2d1aWRlbGluZXMwEQYJYIZIAYb4QgEBBAQDAgWgMF0GCWCG
SAGG+EIBAwRQFk5odHRwczovL3d3dy50cnVzdGNlbnRlci5kZS9jZ2ktYmluL2NoZWNrLXJl
di5jZ2kvRkVERDAwMDAwMDAyQUUyOUMxODI1Mjg0MTcwOT8wDQYJKoZIhvcNAQEEBQADgYEA
GXoxBPaan9VrU2BDy8spnRCprbmBbLiA9LThlXONy75eZtZuMAn5ahj4x3WQaHdGdwFMnkgK
mIY2S54ZUFv/TO3Dl5YfpjlmImsbn2N9jUUMssLRjaKq32x4dWNzGMVoajNY6dqSQOhWhLr7
5Y16fQbREyIeRmixb8/+NgSfRxQxggOTMIIDjwIBATCB0DCBvDELMAkGA1UEBhMCREUxEDAO
BgNVBAgTB0hhbWJ1cmcxEDAOBgNVBAcTB0hhbWJ1cmcxOjA4BgNVBAoTMVRDIFRydXN0Q2Vu
dGVyIGZvciBTZWN1cml0eSBpbiBEYXRhIE5ldHdvcmtzIEdtYkgxIjAgBgNVBAsTGVRDIFRy
dXN0Q2VudGVyIENsYXNzIDEgQ0ExKTAnBgkqhkiG9w0BCQEWGmNlcnRpZmljYXRlQHRydXN0
Y2VudGVyLmRlAg8A/t0AAAACrinBglKEFwkwCQYFKw4DAhoFAKCCAZcwGAYJKoZIhvcNAQkD
MQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDMwNTE4MDY1MTI3WjAjBgkqhkiG9w0B
CQQxFgQUNH9KGHOPebopfaSecltTMqWB8AEwUgYJKoZIhvcNAQkPMUUwQzAKBggqhkiG9w0D
BzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwIC
ASgwgeMGCyqGSIb3DQEJEAILMYHToIHQMIG8MQswCQYDVQQGEwJERTEQMA4GA1UECBMHSGFt
YnVyZzEQMA4GA1UEBxMHSGFtYnVyZzE6MDgGA1UEChMxVEMgVHJ1c3RDZW50ZXIgZm9yIFNl
Y3VyaXR5IGluIERhdGEgTmV0d29ya3MgR21iSDEiMCAGA1UECxMZVEMgVHJ1c3RDZW50ZXIg
Q2xhc3MgMSBDQTEpMCcGCSqGSIb3DQEJARYaY2VydGlmaWNhdGVAdHJ1c3RjZW50ZXIuZGUC
DwD+3QAAAAKuKcGCUoQXCTANBgkqhkiG9w0BAQEFAASCAQDRHZblheWQ22lx7SGQ2oWvXSiK
8PIZqEmWfyGut49tFGTwTF3fXdNOgEAyl4k2d6sbzBmMOOV8shazHLhDxso1NPdc6dy0IymE
JwuJkwnM+UWnCJ8oBbN36I+tXQXnVmKdbQbkhnlogAYGpqW7b/V91ZnI6eAnGyuVlFD7Um4Z
rZxSJulubrlMtiTIIC8gv6k2UVGZRfxSTK/20+LgH7ixBPAUomDr4LfcyRq6FpssWo4cpk5n
4duXawFGcQuT292zJ3NDT/sgn4uLGc24+gB0PZWl4TbvPaK53on+1MwpVk+88JkIo6klb/x/
Ri+tD/rQ/IYmmZXOhWiIn4epBpdYAAAAAAAA
--------------ms020801030308020503050104--

